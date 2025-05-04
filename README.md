# Echo-Server

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
- Embedded **Tomcat** server

---

## **Setup**
### Prerequisites
- Java 21 JDK
- Maven 3.8+

### Installation
1. Clone the repository:
```bash
   git clone https://github.com/your-repo/echo-server.git
   cd echo-server
```
2. Build the project:
```bash
    mvn clean install
```
--- 
## Usage
### Running the Application

Start the server on default port `8080`:
```bash
     mvn spring-boot:run
```
To run on a custom port (e.g., 3001):
```bash
     mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=3001
```

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
Same as request payload

**Example:**

```json
  {
    "game": "Mobile Legends",
    "gamerID": "GYUTDTE",
    "points": 20
  }
```