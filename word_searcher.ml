(*Tip stanje*)
type state = {
  index : int; 
  output : string; (*String končnega outputa, na dani točki v stringu (1, če se je na tej točki končal zorec, ki ga uporabnik želi, 0 sicer)*)
  count : int; (*Število pojavitev vzorca*)
}


let initial_state = {
  index = 0;
  output = "";
  count = 0;
}

(* Tabela za delno ujemanje za algoritem KMP*)
let kmp_tabela_calc vzorec =
  let m = String.length vzorec in (*dolžina iskanega niza*)
  let table = Array.make m 0 in (*Ustvari matriko ničel velikosti 1 x m*)
  let j = ref 0 in (*dolžina ustreznega dela besede*)
  for i = 1 to m - 1 do
    while !j > 0 && vzorec.[!j] <> vzorec.[i] do(*dokler ne najdemo ujemanja z ustreznim znakom oziroma dokler ne pridmeo na 0 zmanjšujemo vrednost j*)
      j := table.(!j - 1)
    done;
    if vzorec.[!j] = vzorec.[i] then incr j;(*če je ustrezen znak vrednost j povečamo za 1*)
    table.(i) <- !j (*na i-to mesto shrani vrednost j*)
  done;
  table

(*Tranzicije mealyevega stroja*)
let proc_znak (vzorec : string) (kmp_table : int array) (current_state : state) (char : char) : state =(*char je trenutni element, ki ga procesiramo*)
  let vzorec_len = String.length vzorec in
  let new_index = ref current_state.index in(*mesto v vzorcu, ki ga bomo sedja preverili*)
  while !new_index > 0 && vzorec.[!new_index] <> char do(*sprmeeni "new_index", kadar prude do neujemanja in si pomaga s kmp_tabelo*)
    new_index := kmp_table.(!new_index - 1)
  done;
  if vzorec.[!new_index] = char then incr new_index;
(*če je znak v vzorcu na poziciji new_index tisti, ki ga trenutno opazujemo se premaknemo na naslednjo pozicijo v vzorcu -> znak torej podaljša ujemanje*)
  let new_output = (*če je vrednost new_index enaka dolžini vzorca, ki ga iščemo smo našli polno ujemanje, torej v avtomatu stanje postane 1, sicer ostane 0*)
    if !new_index = vzorec_len then 
      current_state.output ^ "1"
    else 
      current_state.output ^ "0"
  in
  let new_count =(*če smo našli nov celoten vzorec povečamo count za 1*)
    if !new_index = vzorec_len then current_state.count + 1 else current_state.count
  in
  (*začnemo z naslednjim znakom, kjer index na stavimo na 0, če imamo polno ujemanje, sicer pa nadaljujemo s starim indeksom*)
  { index = if !new_index = vzorec_len then 0 else !new_index; output = new_output; count = new_count }

(*Funckija za poganjanje celotnega teksta skozi Mealyev stroj*)
let process_text (text : string) (vzorec : string) : (string * int) =
  let kmp_table = kmp_tabela_calc vzorec in (*ustvarimo kmp tabelo*)
  let char_seq = String.to_seq text in (*tekst spremenimo v zaporednje*)
  let final_state = Seq.fold_left (proc_znak vzorec kmp_table) initial_state char_seq in (*S foldom opravimo funckijo za vsak znak*)
  (final_state.output, final_state.count)

  
(*--Tekstovni vmesnik--*)
let () =
  Printf.printf "Vnesi besedilo: ";
  let text = read_line () in
  Printf.printf "Vnesi vzorec: ";
  let vzorec = read_line () in
  let (rez, stevilo) = process_text text vzorec in
  
  Printf.printf "----------\n";
  Printf.printf "Rezultat: %s\n" rez;
  Printf.printf "Število pojavitev: %d\n" stevilo
(*--Tekstovni vmesnik--*)