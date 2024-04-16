;; extends
;; mark "use client" and "use server" as keyword directives
((string_fragment) @keyword.directive
  (#match? @keyword.directive "^use [a-z]+$"))

;; spell check variable names
(variable_declarator
  ((identifier) @spell))
