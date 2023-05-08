local status, cmp = pcall(require, 'cmp')

if (not status) then return end

local lspkind = require('lspkind')
local luasnip = require('luasnip')

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- Show auto completion
		['<C-Space>'] = cmp.mapping.complete(),
		-- Select next item
		['<Tab>'] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		-- Trigger autocompletion
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		})
	}),
	sources = cmp.config.sources({
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
		{ name = 'buffer' }
	}),
	formatting = {
		format = lspkind.cmp_format({
			wirth_text = false,
			maxwidth = 50
		})
	}
})

vim.cmd [[
	set completeopt=menuone,noinsert,noselect
	highlight! default link CmpItemKind CmpItemMenuDefault
]]
