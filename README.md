# Echo-Service

A lightweight Spring Boot API that echoes back JSON payloads.

---
## **Features**
- Accepts `HTTP POST` requests with any JSON payload.
- Returns the same JSON with a `201 CREATED` response.
- Ready for horizontal scaling (run multiple instances on different ports).

---
## **Technologies**
- **Java 21**
- **Spring Boot 3.x**
- **Maven** (dependency management)

---
## **Setup**
### Prerequisites
- Java 21 JDK
- Maven 3.8+

### Installation
1. Clone the repository:
```bash
   git clone https://github.com/genezeiniss/echo-service.git
   cd echo-service
```
2. Build the project:
```bash
    mvn clean install
```
--- 
## Usage
### Running the Application
1. Make `echo.sh` script executable
```bash
    chmod +x echo.sh
```
2. Create required directories:
```bash
    mkdir -p pids logs
```
3. Command Reference:

| Command         | Description                              | Example                   |
|-----------------|------------------------------------------|---------------------------|
| `start-cluster` | Starts 3 instances (ports 3001-3003)     | `./echo.sh start-cluster` |
| `start`         | Starts single instance on specified port | `./echo.sh start 3004`    |
| `stop`          | Stops instance on specified port         | `./echo.sh stop 3002`     |
| `restart`       | Restarts instance on specified port      | `./echo.sh restart 3001`  |
| `list`          | Shows all running instances              | `./echo.sh list`          |

---
## API Endpoint

**Method**: `POST /api/echo`

### Request
Any valid JSON payload

**Example**:
```json
  {
    "game": "Mobile Legends",
    "gamerID": "GYUTDTE",
    "points": 20
  }
```

### Response: 
Same as the request payload

**Example:**

```json
  {
    "game": "Mobile Legends",
    "gamerID": "GYUTDTE",
    "points": 20
  }
```
