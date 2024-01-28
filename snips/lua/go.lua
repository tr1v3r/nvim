local snippets = {}

-- https://zjp-cn.github.io/neovim0.6-blogs/nvim/luasnip/doc1.html

table.insert(snippets, s({ trig = "trigger", dscr = "lua snippets test" }, fmt("test {{\n\treturn {}\n}}", { i(1) })))

-- table.insert(snippets, s("autotrig", t("autotriggered, if enabled")))

-- table.insert(
-- 	snippets,
-- 	s("trig2", {
-- 		t({ "After expanding, the cursor is here ->" }),
-- 		i(1),
-- 		t({ "", "After jumping forward once, cursor is here ->" }),
-- 		i(2),
-- 		t({ "", "After jumping once more, the snippet is exited there ->" }),
-- 		i(0),
-- 	})
-- )

return snippets
