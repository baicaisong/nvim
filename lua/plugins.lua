vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    
    use 'nvim-treesitter/nvim-treesitter'

    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

		use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
    }

	

end)

