return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local logo = [[
                                                       
 _|      _|  _|_|_|    _|      _|  _|_|_|  _|      _|  
 _|_|    _|  _|    _|  _|      _|    _|    _|_|  _|_|  
 _|  _|  _|  _|_|_|    _|      _|    _|    _|  _|  _|  
 _|    _|_|  _|          _|  _|      _|    _|      _|  
 _|      _|  _|            _|      _|_|_|  _|      _|  
                                                       
                                                       
                                        [@Abimael]
]]
    opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
  end,
}
