local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s({trig = "make"},fmt(
   [[CC := gcc
CFLAGS := -Wall -Wextra -Werror --std=c99
LDFLAGS := 
BUILD := build
SRC := src
TARGET := main

.PHONY: all clean run

all: $(BUILD)/$(TARGET)

$(BUILD)/$(TARGET): $(SRC)/main.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

clean:
	rm -rf $(BUILD)

run: all
	./$(BUILD)/$(TARGET)]] , {})),
}

