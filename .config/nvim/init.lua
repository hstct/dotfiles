local present, impatient = pcall(require, "impatient")
if present then
  impatient.enable_profile()
end

require("hstct.settings")
require("hstct.autocmd")
require("hstct.plugins")
require("hstct.commands")
require("hstct.keybinds")
