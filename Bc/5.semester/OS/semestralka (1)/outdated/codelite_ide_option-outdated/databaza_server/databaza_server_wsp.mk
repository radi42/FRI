.PHONY: clean All

All:
	@echo ----------Building project:[ databaza_server - Debug ]----------
	@cd "databaza_server" && "$(MAKE)" -f "databaza_server.mk"
clean:
	@echo ----------Cleaning project:[ databaza_server - Debug ]----------
	@cd "databaza_server" && "$(MAKE)" -f "databaza_server.mk" clean
