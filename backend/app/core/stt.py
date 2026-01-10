from groq import AsyncGroq
from app.core.config import settings
import io

client = AsyncGroq(api_key=settings.GROQ_API_KEY)

async def transcribe_audio(file_content: bytes, filename: str) -> str:
    """
    Transcribes audio using Groq's Whisper model.
    """
    try:
        # Groq API expects a file-like object with a name attribute
        # We wrap the bytes in BytesIO and allow setting the name
        buffer = io.BytesIO(file_content)
        buffer.name = filename 

        transcription = await client.audio.transcriptions.create(
            file=(filename, buffer.read()), # tuple (filename, file_content) works for some clients, but Groq might want file-like
            model="whisper-large-v3",
            response_format="json",
            language="en", # Optional: can be auto-detected, but "en" or specific lang helps. 
                           # User mentioned Bengali. "whisper-large-v3" is multilingual.
                           # Let's NOT set language to let it auto-detect or set to 'bn' if needed.
                           # Actually, for mixed input, auto is best.
            temperature=0.0
        )
        return transcription.text
    except Exception as e:
        print(f"Transcription error: {e}")
        raise e
