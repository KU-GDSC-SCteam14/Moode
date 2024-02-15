from timer import timer
from google.cloud import translate

@timer
def translate_text(
    text: str = "YOUR_TEXT_TO_TRANSLATE", project_id: str = "gdsc-solutionchallenge-team14"
) -> translate.TranslationServiceClient:
    """Translating Text."""

    client = translate.TranslationServiceClient()

    location = "global"

    parent = f"projects/{project_id}/locations/{location}"

    response = client.translate_text(
        request={
            "parent": parent,
            "contents": [text],
            "mime_type": "text/plain",  # mime types: text/plain, text/html
            "source_language_code": "ko",
            "target_language_code": "en-US",
        }
    )

    return response