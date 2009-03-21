(+ 1 1)

(. javax.swing.JOptionPane (showMessageDialog nil "Hello World"))

(defmacro widget
  "Docstring!" [a]
  ,(+ 1 `a))

(widget 4)xbdat
