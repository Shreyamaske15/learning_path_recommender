#!/usr/bin/env bash
# Launches the FastAPI backend and Streamlit frontend together.
# Usage: ./run.sh
set -e

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "WARNING: ANTHROPIC_API_KEY is not set. Copy .env.example to .env and add your key."
fi

echo "Starting FastAPI backend on http://localhost:8000 ..."
(cd backend && uvicorn main:app --reload --port 8000) &
BACKEND_PID=$!

sleep 2

echo "Starting Streamlit frontend on http://localhost:8501 ..."
streamlit run frontend/app.py

kill $BACKEND_PID
