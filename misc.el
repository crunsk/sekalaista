(defun o-add-new-var ()
  (interactive)
  (let ((beg (point))
  (search-backward "let")
  (forward-word)
  (forward-sexp)
  (backward-char)
  (insert "()")
  (backward-char)
  )))

(defun o-add-new-var% ()
  "You have to have multiple-cursors package installed for this. Method adds new empty list to let variable portion and creates a new cursor where the command was given. This way you can give a name for the value you were going to insert"
  (interactive)
  (let ((beg 0) ;beginning position for cursor where the command begins
	(let-pos 0) ;cursor position inside creted cons in let variable definitions
	)
    (setf beg (+ (point) 2)) ;;have to add to here because I will add to characters () later. If 2 is not added it will seem like cursor does not return to it's original position
    (print (point))
    (search-backward "let")
    (print "backward")
    (forward-word)
    (forward-sexp)
    (backward-char)
    (insert "()")
    (backward-char)
    (setf let-pos (point))
    (push-mark)
    (print "set mark end")
    (goto-char beg)
    (mc/mark-pop)
    ))

(defun o-add-new-var%% ()
  "You have to have multiple-cursors package installed for this. Method adds new empty list to let variable portion and creates a new cursor where the command was given. This way you can give a name for the value you were going to insert.
Previous version did not work when trying the function on it's implementation. When it was searching backward from cursor position it found the command (search-backward \"let\" before actual let. So I changed it start searching forward from the beginning of function definition."
  
  (interactive)
  (let ((beg 0) ;beginning position for cursor where the command begins
	(let-pos 0) ;cursor position inside creted cons in let variable definitions
	(new-var-string "()") ; this is the string which is added to the end of let's variable list
	)
    (setf beg (+ (point) (length new-var-string))) ;;have to add to here because I will add to characters () later. If 2 is not added it will seem like cursor does not return to it's original position
    (print (point))
    (beginning-of-defun)
    (search-forward "(let ")
    (forward-sexp)
    (backward-char)
    (insert new-var-string)
    (backward-char)
    (setf let-pos (point))
    (push-mark)
    (goto-char beg)
    (mc/mark-pop)))
