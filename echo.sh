#!/bin/bash
# echo.sh - Unified control script for echo-service instances

BASE_DIR=$(dirname "$0")
mkdir -p "$BASE_DIR/pids" "$BASE_DIR/logs"

start_instance() {
  local port=$1
  echo "Starting echo-service on port $port"
  nohup mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=$port" > "$BASE_DIR/logs/echo-$port.log" 2>&1 &
  echo $! > "$BASE_DIR/pids/echo-$port.pid"
  echo "✅ Instance started (PID: $!, port: $port)"
}

stop_instance() {
  local port=$1
  local pid_file="$BASE_DIR/pids/echo-$port.pid"

  if [ ! -f "$pid_file" ]; then
    echo "❌ Error: No service running on port $port"
    return 1
  fi

  local pid=$(cat "$pid_file")
  if kill $pid; then
    rm "$pid_file"
    echo "✅ Stopped instance (port: $port, PID: $pid)"
  else
    echo "❌ Failed to stop instance (port: $port)"
    return 1
  fi
}

list_instances() {
  echo "Active echo-service instances:"
  echo "------------------------------"

  for pid_file in $BASE_DIR/pids/echo-*.pid; do
    [ -e "$pid_file" ] || continue
    local port=$(basename "$pid_file" | cut -d'-' -f2 | cut -d'.' -f1)
    local pid=$(cat "$pid_file")

    if ps -p $pid > /dev/null; then
      status="RUNNING"
    else
      status="DEAD"
    fi

    echo -e "Port: $port \t PID: $pid \t Status: $status"
  done
}

case "$1" in
  start-cluster)
    for port in {3001..3003}; do
      start_instance $port
    done
    ;;

  start)
    if [ -z "$2" ]; then
      echo "Usage: $0 start <port>"
      exit 1
    fi
    start_instance "$2"
    ;;

  stop)
    if [ -z "$2" ]; then
      echo "Usage: $0 stop <port>"
      exit 1
    fi
    stop_instance "$2"
    ;;

  list)
    list_instances
    ;;

  restart)
    if [ -z "$2" ]; then
      echo "Usage: $0 restart <port>"
      exit 1
    fi
    stop_instance "$2" && start_instance "$2"
    ;;

  *)
    echo "Echo Service Manager"
    echo "Usage: $0 {command} [port]"
    echo ""
    echo "Commands:"
    echo "  start-cluster         Start 3 instances (ports 3001-3003)"
    echo "  start <port>          Start single instance"
    echo "  stop <port>           Stop specific instance"
    echo "  restart <port>        Restart specific instance"
    echo "  list                  List all running instances"
    exit 1
    ;;
esac