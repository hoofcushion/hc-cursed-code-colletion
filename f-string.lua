local f; f={
 __tostring=function(t)
  return tostring(rawget(t,1))
 end,
 __call=function(t,v)
  local s=rawget(t,1) or ""
  if type(v)=="table" then
   v=v[1]
  end
  v=v or ""
  return setmetatable({s..v},f)
 end,
}
f=setmetatable(f,f)
local timeout=10000
print(f"timeout after "{timeout}" ms")
local answer=42
print(f"the answer of the universe is "{answer})
