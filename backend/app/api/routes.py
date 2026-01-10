from fastapi import APIRouter, UploadFile, File, HTTPException
from app.models.task import ProcessingRequest, AgentResponse, TaskItem
from app.core.agent import parse_transcript
# from app.core.stt import transcribe_audio # To be implemented
from typing import List

router = APIRouter()

# In-memory database for MVP
TASKS_DB: List[TaskItem] = []

@router.post("/stt/on-device", response_model=AgentResponse)
async def process_on_device_transcript(request: ProcessingRequest):
    response = await parse_transcript(request.transcript, request.user_timezone)
    return response

from app.core.stt import transcribe_audio

@router.post("/stt/whisper", response_model=AgentResponse)
async def process_audio_file(file: UploadFile = File(...), user_timezone: str = "UTC"):
    # Read file content
    content = await file.read()
    # Transcribe
    transcript = await transcribe_audio(content, file.filename)
    # Parse
    response = await parse_transcript(transcript, user_timezone)
    return response

@router.post("/tasks", response_model=TaskItem)
async def create_task(task: TaskItem):
    TASKS_DB.append(task)
    return task

@router.get("/tasks", response_model=List[TaskItem])
async def get_tasks():
    return TASKS_DB

@router.post("/agent/parse", response_model=AgentResponse)
async def manual_parse(request: ProcessingRequest):
    # Same as stt/on-device for now, but semantically distinct
    return await parse_transcript(request.transcript, request.user_timezone)
