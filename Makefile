.PHONY : migrations

migrations :
	./runflyway migrate
	./runflyway info

migration-info :
	./runflyway info


run-nodocker :
	python3 runserver.py


