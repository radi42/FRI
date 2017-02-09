#include "KoniecCommand.h"


KoniecCommand::KoniecCommand(IVystup &vystup, IReceiver *receiver)
	: TextCommand("[K]oniec", vystup, KONIEC_ID, 'k', receiver)
{
}

bool KoniecCommand::execute(){
	return !TextCommand::execute();
}