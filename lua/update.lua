local curl = require("lcurl")
local zipUrl = "http://music9.online/att/autoclaim.zip"
local savePath = "/private/var/mobile/Library/AutoTouch/Scripts/autoclaim.zip"
local extractTo = "/private/var/mobile/Library/AutoTouch/Scripts"

-- Mở file để ghi nội dung tải về
local file = io.open(savePath, "wb")
assert(file, "Không thể tạo file zip tạm thời!")

-- Tải file zip
local easy = curl.easy{
  url = zipUrl,
  writefunction = function(data)
    file:write(data)
    return #data
  end
}

local success, err = pcall(function()
  easy:perform()
end)

easy:close()
file:close()

if success then
  toast("✅ Tải file zip thành công!",2)

  -- Giải nén file zip
  local unzipCmd = string.format('unzip -o "%s" -d "%s"', savePath, extractTo)
  local result = execute(unzipCmd)
  toast("✅ Giải nén thành công!",5)
end