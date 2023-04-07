CC = gcc
FLEX = flex
BISON = bison
CFLAGS = -std=c99

CFILES = $(shell find ./ -name "*.c")
OBJS = $(CFILES:.c=.o)
LFILE = $(shell find ./ -name "*.l")
YFILE = $(shell find ./ -name "*.y")
LFC = $(shell find ./ -name "*.l" | sed s/[^/]*\\.l/lex.yy.c/)
YFC = $(shell find ./ -name "*.y" | sed s/[^/]*\\.y/syntax.tab.c/)
LFO = $(LFC:.c=.o)
YFO = $(YFC:.c=.o)

parser: syntax $(filter-out $(LFO),$(OBJS))
	$(CC) -o parser $(filter-out $(LFO),$(OBJS)) -lfl -ly

syntax: lexical syntax-c
	$(CC) -c $(YFC) -o $(YFO)

lexical: $(LFILE)
	$(FLEX) -o $(LFC) $(LFILE)

syntax-c: $(YFILE)
	$(BISON) -o $(YFC) -d -v $(YFILE)

-include $(patsubst %.o, %.d, $(OBJS))

# 定义的一些伪目标
.PHONY: clean test make run
make:
	$(FLEX) $(LFILE)
	$(BISON) -d $(YFILE)
	$(CC) ./main.c ./syntax.tab.c -lfl -ly -o parser
run:
	@make -s
clean:
	@rm -f parser lex.yy.c syntax.tab.c syntax.tab.h syntax.output syntax.tab.o
	@rm -f $(OBJS) $(OBJS:.o=.d)
	@rm -f $(LFC) $(YFC) $(YFC:.c=.h)
#	rm -f *~
