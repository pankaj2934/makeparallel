#hello world makefile
#all: hello
# hello:
# 	# call my_function with xargs here 
# 	$(call my_function)


define my_function
	# Code goes here.
	name=$$(basename $$0)
	echo "Building $$name function locally..."; \
	echo "hello world -- $$name "
	docker build --force-rm --build-arg FUNC_NAME=$$name -t $$name:latest -f lambda/$$name/Dockerfile . || { exit 1; };
	#touch $$name.txt
	#sleep 5;
endef
export my_function

# xargs arguments help
# -n 1 : one argument per line
# -P 0 : run in parallel
# -t : print command before executing


pl:
	# call my_function with xargs here 
	#@echo lambda/a lambda/b lambda/c lambda/d | tr ' ' '\n' | xargs -n 1  -P 0 bash -c 'eval "$$my_function" '
	echo lambda/* | tr ' ' '\n' | xargs -n 1 -t -P 0 bash -c 'eval "$$my_function" '
	
sl:
	# call my_function with xargs here 
	#@echo lambda/a lambda/b lambda/c lambda/d | tr ' ' '\n' | xargs -n 1 -t -P 1 bash -c 'eval "$$my_function" '
	echo lambda/* | tr ' ' '\n' | xargs -n 1 -t -P 1 bash -c 'eval "$$my_function" '
	