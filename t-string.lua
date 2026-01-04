local Template={
 delimiter="%$",
 pattern=("[A-Za-z_][A-Za-z0-9_]*"),
}
Template.__index=Template
function Template.new(str,delimiter)
 local obj=setmetatable({},Template)
 if delimiter then
  obj.delimiter=delimiter
 end
 obj.str=str
 obj.token=obj:_parse()
 return obj
end
function Template:_parse()
 local token={}
 for s,name,e in string.gmatch(self.str,"()"..self.delimiter.."("..self.pattern..")".."()") do
  table.insert(token,{name=name,pos={s,e-1}})
 end
 return token
end
function Template:substitute(data)
 local str=self.str
 local fragments={}
 local last_e=1
 for _,token in ipairs(self.token) do
  local name,pos=token.name,token.pos
  local value=data[name]
  if value==nil then
   value=""
  end
  local s,e=pos[1],pos[2]
  table.insert(fragments,string.sub(str,last_e,s-1))
  last_e=e+1
  table.insert(fragments,tostring(value))
 end
 table.insert(fragments,string.sub(str,last_e))
 return table.concat(fragments)
end
local t=Template.new("$greet, $name!")
print(t:substitute({greet="Hello",name="World"}))      -- Hello, World!
local tsharp=Template.new("#greet, #name!","#")
print(tsharp:substitute({greet="Hello",name="World"})) -- Hello, World!
