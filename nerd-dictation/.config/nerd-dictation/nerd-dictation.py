# Nerd-dictation configuration for punctuation support
# This file is automatically loaded by nerd-dictation

substitutions = [
    # Standard punctuation
    ('period', '.'),
    ('comma', ','),
    ('question mark', '?'),
    ('exclamation mark', '!'),
    ('exclamation point', '!'),
    ('colon', ':'),
    ('semicolon', ';'),

    # Quotes and brackets
    ('quote', '"'),
    ('open quote', '"'),
    ('close quote', '"'),
    ('apostrophe', "'"),
    ('open paren', '('),
    ('close paren', ')'),
    ('open bracket', '['),
    ('close bracket', ']'),
    ('open brace', '{'),
    ('close brace', '}'),

    # Other
    ('dash', '-'),
    ('hyphen', '-'),
    ('underscore', '_'),
    ('new line', '\r'),
    ('new paragraph', '\r\r'),
]

def nerd_dictation_process(text):
    """Process text to replace spoken punctuation with actual punctuation marks."""
    for old, new in substitutions:
        # Replace with preceding space (mid-sentence)
        text = text.replace(' ' + old, new)
        # Replace without space (start of dictation)
        text = text.replace(old, new)

    # Clean up spacing around line breaks
    text = text.replace('\r ', '\r')

    return text
