function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
function first_then_lower_case(a, p)
    for _, string in ipairs(a) do
        if p(string) then
            return string:lower()
        end
    end
    return nil
end

-- Write your powers generator here
function powers_generator(base, limit)
    return coroutine.create(function()
        local power = 0
        while true do
            local result = base ^ power
            if result > limit then
                return
            end
            coroutine.yield(result)
            power = power + 1
        end
    end)
end

-- Write your say function here
function say(initial_word)
    local words = {}
    
    local function extra(word)
        if word == nil then
            return table.concat(words, " ")
        end
        table.insert(words, word)
        return extra
    end
    
    return extra(initial_word)
end

-- Write your line count function here

local open = io.open

function meaningful_line_count(path)
    local file = open(path, "r") 
    if not file then 
    error("No such file")
   end
   count = 0
   currentLine = file:read "*l"
   while currentLine ~= nil do
    while string.gsub(currentLine, "%s+", "") == '' or (string.gsub(currentLine, "%s+", "")):sub(1, 1) == "#" do
        currentLine = file:read "*l"
    end
    currentLine = file:read "*l"
    count = count + 1
  end
    
    file:close()
    return count
end

-- Write your Quaternion table here
Quaternion = {}
Quaternion.__index = Quaternion

function Quaternion.new(a, b, c, d)
    return setmetatable({a = a or 0, b = b or 0, c = c or 0, d = d or 0}, Quaternion)
end

function Quaternion:coefficients()
    return {self.a, self.b, self.c, self.d}
end

function Quaternion.__add(q1, q2)
    return Quaternion.new(q1.a + q2.a, q1.b + q2.b, q1.c + q2.c, q1.d + q2.d)
end

function Quaternion.__mul(q1, q2)
    return Quaternion.new(
        q1.a * q2.a - q1.b * q2.b - q1.c * q2.c - q1.d * q2.d,
        q1.a * q2.b + q1.b * q2.a + q1.c * q2.d - q1.d * q2.c,
        q1.a * q2.c - q1.b * q2.d + q1.c * q2.a + q1.d * q2.b,
        q1.a * q2.d + q1.b * q2.c - q1.c * q2.b + q1.d * q2.a
    )
end

function Quaternion:conjugate()
    return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

function Quaternion.__eq(q1, q2)
    return q1.a == q2.a and q1.b == q2.b and q1.c == q2.c and q1.d == q2.d
end

function Quaternion.__tostring(q)
    local function format_term(coef, term)
        if coef == 0 then return "" end
        local str = coef == 1 and "" or coef == -1 and "-" or tostring(coef)
        return (coef > 0 and "+" or "") .. str .. term
    end

    local str = q.a ~= 0 and tostring(q.a) or ""
    str = str .. format_term(q.b, "i")
    str = str .. format_term(q.c, "j")
    str = str .. format_term(q.d, "k")
    
    str = str:gsub("^%+", "")
    return str == "" and "0" or str
end