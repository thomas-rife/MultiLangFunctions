exception Negative_Amount

let change amount =
  if amount < 0 then
    raise Negative_Amount
  else
    let denominations = [25; 10; 5; 1] in
    let rec aux remaining denominations =
      match denominations with
      | [] -> []
      | d :: ds -> (remaining / d) :: aux (remaining mod d) ds
    in
    aux amount denominations

let first_then_apply (array: 'a list) (predicate: 'a -> bool) (consumer: 'a -> 'b option) =
  List.find_opt predicate array |> Option.map consumer |> Option.join

let powers_generator base =
  let rec gen_from power () =
    Seq.Cons (power, gen_from (power * base))
  in
  gen_from 1

let meaningful_line_count file_path =
  let is_meaningful_line line =
    let trimmed_line = String.trim line in
    trimmed_line <> "" && not (String.starts_with ~prefix:"# " trimmed_line)
  in

  let rec count_meaningful_lines input_channel current_count =
    match input_line input_channel with
    | line ->
      let updated_count = 
        if is_meaningful_line line then 
          current_count + 1 
        else 
          current_count 
      in
      count_meaningful_lines input_channel updated_count
    | exception End_of_file -> current_count
  in

  let input_channel = open_in file_path in
  let close_channel () = close_in input_channel in
  
  Fun.protect ~finally:close_channel (fun () -> count_meaningful_lines input_channel 0)
  
type shape =
  | Sphere of float
  | Box of float * float * float

let volume shape =
  match shape with
  | Sphere radius -> (4.0 /. 3.0) *. Float.pi *. (radius ** 3.0)
  | Box (width, length, depth) -> width *. length *. depth

let surface_area shape =
  match shape with
  | Sphere radius -> 4.0 *. Float.pi *. (radius ** 2.0)
  | Box (width, length, depth) -> 2.0 *. ((width *. length) +. (width *. depth) +. (length *. depth))

type 'a binary_search_tree =
  | Empty
  | Node of 'a * 'a binary_search_tree * 'a binary_search_tree

let rec insert new_value bst =
  match bst with
  | Empty -> Node (new_value, Empty, Empty)
  | Node (current_value, left_subtree, right_subtree) ->
    if new_value < current_value then
      Node (current_value, insert new_value left_subtree, right_subtree)
    else if new_value > current_value then
      Node (current_value, left_subtree, insert new_value right_subtree)
    else
      bst

let rec size bst =
  match bst with
  | Empty -> 0
  | Node (_, left_subtree, right_subtree) -> size left_subtree + size right_subtree + 1

let rec contains search_value bst =
  match bst with
  | Empty -> false
  | Node (current_value, left_subtree, right_subtree) ->
    if search_value < current_value then
      contains search_value left_subtree
    else if search_value > current_value then
      contains search_value right_subtree
    else
      true 

let rec inorder bst =
  match bst with
  | Empty -> []
  | Node (current_value, left_subtree, right_subtree) ->
      inorder left_subtree @ [current_value] @ inorder right_subtree
