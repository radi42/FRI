#include "TextCommand.h"


TextCommand::TextCommand(string text, IVystup &vystup, int id, char hotkey, IReceiver *receiver)
	:aText(text), aVystup(vystup), aId(id), aHotKey(hotkey), aReceiver(receiver)
{
}

bool TextCommand::execute(){
	if (aReceiver)
		aReceiver->action(aId);

	return true;
}

int TextCommand::id(){
	return aId;
}

void TextCommand::zobraz(){
	aVystup.zobraz(aText);
}

bool TextCommand::jeHotKey(char key){
	return key == aHotKey;
}