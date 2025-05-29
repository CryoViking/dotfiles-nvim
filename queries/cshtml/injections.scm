((script_element
  (raw_text) @injection.content)
 (#set! injection.language "javascript"))

((style_element
  (raw_text) @injection.content)
 (#set! injection.language "css"))

; SECTION: Inject C# highlighting into CSHTML C# blocks

((quoted_attribute_value
  (csharp_text) @injection.content)
 (#set! injection.language "c_sharp"))

((razor_directive
  (csharp_til_eol) @injection.content)
 (#set! injection.language "c_sharp"))

((razor_directive
  (csharp_value) @injection.content)
 (#set! injection.language "c_sharp"))

((razor_directive
  (csharp_text) @injection.content)
 (#set! injection.language "c_sharp"))

((razor_expression) @injection.content
 (#set! injection.language "c_sharp"))

((razor_expression
  (csharp_value) @injection.content)
 (#set! injection.language "c_sharp"))

((razor_expression
  (csharp_text) @injection.content)
 (#set! injection.language "c_sharp"))

((razor_code_block) @injection.content
 (#set! injection.language "c_sharp"))

((razor_control_structure) @injection.content
 (#set! injection.language "c_sharp"))

((razor_control_structure
  (csharp_text) @injection.content)
 (#set! injection.language "c_sharp"))
