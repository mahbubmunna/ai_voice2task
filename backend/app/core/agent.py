from groq import Groq
from app.core.config import settings
from app.models.task import AgentResponse, TaskItem, IntentType
import json
import datetime

client = Groq(api_key=settings.GROQ_API_KEY)

SYSTEM_PROMPT = """
You are an AI assistant that converts voice transcripts into structured tasks, reminders, calendar events, or notes.
Your output must be strict JSON matching the following schema:
{
  "type": "task | reminder | calendar | note",
  "tasks": [
    {
      "title": "Short title",
      "description": "More details if available",
      "due_datetime": "ISO 8601 string or null",
      "reminder_datetime": "ISO 8601 string or null",
      "confidence": 0.0 to 1.0
    }
  ],
  "needs_clarification": boolean,
  "clarification_question": "Question if needs_clarification is true"
}

Current Time: {current_time}

Rules:
1. Extract intent correctly.
2. Normalize dates/times relative to Current Time.
3. If the user mentions multiple tasks, create multiple entries in the 'tasks' array.
4. If some info is missing but the intent is clear, do NOT ask for clarification, just leave fields null.
5. Only ask for clarification if the transcript is ambiguous or cut off.
6. Support Bengali and English mixed input.
"""

async def parse_transcript(transcript: str, user_timezone: str = "UTC") -> AgentResponse:
    current_time = datetime.datetime.now().isoformat()
    
    completion = client.chat.completions.create(
        model="llama3-70b-8192",
        messages=[
            {"role": "system", "content": SYSTEM_PROMPT.format(current_time=current_time)},
            {"role": "user", "content": transcript}
        ],
        temperature=0.0,
        response_format={"type": "json_object"}
    )
    
    content = completion.choices[0].message.content
    try:
        data = json.loads(content)
        return AgentResponse(**data)
    except Exception as e:
        print(f"Error parsing agent response: {e}")
        # Fallback response
        return AgentResponse(
            type=IntentType.NOTE, 
            tasks=[], 
            needs_clarification=True, 
            clarification_question="Sorry, I couldn't understand that. Could you repeat?"
        )
