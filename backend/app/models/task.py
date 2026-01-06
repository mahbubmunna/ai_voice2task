from pydantic import BaseModel
from typing import List, Optional
from enum import Enum

class IntentType(str, Enum):
    TASK = "task"
    REMINDER = "reminder"
    CALENDAR = "calendar"
    NOTE = "note"

class TaskItem(BaseModel):
    title: str
    description: Optional[str] = None
    due_datetime: Optional[str] = None
    reminder_datetime: Optional[str] = None
    confidence: float

class AgentResponse(BaseModel):
    type: IntentType
    tasks: List[TaskItem]
    needs_clarification: bool
    clarification_question: Optional[str] = None

class ProcessingRequest(BaseModel):
    transcript: str
    user_timezone: str = "UTC"
