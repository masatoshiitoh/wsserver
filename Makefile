REBAR:=rebar

.PHONY: all erl test clean doc

all: erl

erl:
	$(REBAR) get-deps compile

test: all
	@mkdir -p .eunit
	$(REBAR) skip_deps=true eunit

clean:
	$(REBAR) clean
	-rm -rvf deps ebin doc .eunit

doc:
	$(REBAR) doc

release:
	$(REBAR) get-deps compile
	cd rel; $(REBAR) generate

run:
	./rel/wsserver/bin/wsserver start

stop-app:
	./rel/wsserver/bin/wsserver stop

console:
	./rel/wsserver/bin/wsserver attach
