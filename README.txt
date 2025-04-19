
Place both backend and frontend directory that you cloned in the same folder

# Kinetiq-Distribution

### Installation

1.  **Create a virtual environment:** This isolates project dependencies.

    *   **CMD/PowerShell:**
        ```bash
        python -m venv venv
        ```

2.  **Activate the virtual environment:**

    *   **CMD/PowerShell:**
        ```bash
        venv\Scripts\activate
        ```

3.  **Install required Python packages:**

    *   **CMD/PowerShell:**
        ```bash
        python -m pip install -r requirements.txt
        ```

4.  **Install required Node.js packages (frontend):**

    *   **CMD/PowerShell:**
        ```bash
        cd frontend
        npm install --force  # or npm ci for a clean install
        ```

## Running the Program

This section explains how to start the application. Note: Always start a new powershell/command prompt window for each step.

### Frontend

1.  Navigate to the frontend directory:

    *   **CMD/PowerShell:**
        ```bash
        cd kinetiq-frontend
        ```

2.  Start the development server:

    *   **CMD/PowerShell:**
        ```bash
        npm run dev
        ```

### Backend 

1. **Navigate to backend directory
     *   **CMD/PowerShell:**
        ```bash
        cd kinetiq-erp-distribution-backend
        ```
2.  **Activate the virtual environment:**

    *   **CMD/PowerShell:**
        ```bash
        venv\Scripts\activate
        ```

3.  Run the Python application:

    *   **CMD/PowerShell:**
        ```bash
        python manage.py runserver
        ```

