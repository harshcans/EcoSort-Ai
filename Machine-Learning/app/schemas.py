from pydantic import BaseModel, Field
 
 
class PredictionResponse(BaseModel):
    category: str = Field(..., examples=["plastic"])
    confidence: float = Field(..., ge=0.0, le=1.0, examples=[0.93])
