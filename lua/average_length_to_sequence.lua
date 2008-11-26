function flip()
   val = math.random(0,1)
   if val == 1 then
      return 'h'
   else
      return 't'
   end
end

function check_length_to_sequence_helper(target, running, running_total)
   if target == running then
      return running_total
   else
      running = string.sub(running, 2) .. flip()
      return check_length_to_sequence_helper(target, running, running_total + 1)
   end
end

function check_length_to_sequence(sequence)
   return check_length_to_sequence_helper(sequence, 'xxx', 0)
end

function find_average_length_to_sequence(sequence)
   iterations = 11000
   total_length = 0
   for i = 1,iterations do
      total_length = check_length_to_sequence(sequence) + total_length
   end
   return total_length / iterations
end

function print_run_for(sequence)
   length = find_average_length_to_sequence(sequence)
   print(sequence .. '  [' .. string.rep('=', (2 * length)) .. string.rep('-', 36 - (2 * length)) .. '] (' .. length .. ')')
end

math.randomseed(os.time())

options = {}
options[1] = 'h'
options[2] = 't'

for i,coinval1 in ipairs(options) do
   for i,coinval2 in ipairs(options) do
      for i,coinval3 in ipairs(options) do
	 print_run_for(coinval1 .. coinval2 .. coinval3)
      end
   end
end
