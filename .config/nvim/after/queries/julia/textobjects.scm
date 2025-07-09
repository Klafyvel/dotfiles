([
  (
   (line_comment)+ @comment_before
   .
   (
    ((_) @_inner (#not-has-type? @_inner line_comment)) 
    (#has-parent? @_inner source_file)
   ) @code_cell.inner
   .
   (line_comment)+ @comment_after
  )
  (
   (
    ((_) @_inner (#not-has-type? @_inner line_comment)) 
    (#has-parent? @_inner source_file)
   ) @code_cell.inner
   .
   (line_comment)+ @comment_after
  )
  (
   (line_comment)+ @comment_before
   .
   (
    ((_) @_inner (#not-has-type? @_inner line_comment)) 
    (#has-parent? @_inner source_file)
   ) @code_cell.inner
  )
] @code_cell.outer)
