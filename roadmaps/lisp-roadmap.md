# 🛣️ Roadmap para Aprender Lisp (Common Lisp)

---

## ✅ 1. Fundamentos básicos de Lisp

**🎯 Objetivo:** Familiarizarte con la sintaxis y tipos de datos.

### Contenidos:

* Qué es Lisp y qué lo hace único.
* Leer/evaluar expresiones (`s-expressions`).
* Tipos básicos:

  * Números, cadenas, símbolos, booleanos.
  * Listas y pares (`cons`, `car`, `cdr`).
* Funciones integradas: `+`, `-`, `list`, `cons`, `car`, `cdr`, `length`, etc.
* Evaluación de expresiones: `eval` y `quote`.
* Variables con `setq` y `let`.

### 🧰 Herramientas:

* Emacs + SLIME o [Portacle](https://portacle.github.io/)
* Intérprete REPL: `sbcl` o `clisp`

---

## ✅ 2. Funciones y flujo de control

**🎯 Objetivo:** Escribir tus propias funciones y controlar la lógica del programa.

### Contenidos:

* Definir funciones con `defun`
* Recursión
* Condicionales: `if`, `cond`, `when`, `unless`
* Bloques con `progn`, `block`, `return-from`

---

## ✅ 3. Estructuras de datos complejas

**🎯 Objetivo:** Trabajar con estructuras útiles para problemas reales.

### Contenidos:

* Listas vs vectores
* Tablas hash: `make-hash-table`, `gethash`
* Definición de estructuras con `defstruct`

---

## ✅ 4. Funciones de orden superior y programación funcional

**🎯 Objetivo:** Pensar de forma funcional.

### Contenidos:

* `mapcar`, `reduce`, `filter`, `remove`, etc.
* Funciones anónimas con `lambda`
* Aplicar funciones: `apply`, `funcall`

---

## ✅ 5. Macros y metaprogramación

**🎯 Objetivo:** Manipular código como datos.

### Contenidos:

* Diferencia entre funciones y macros
* Sintaxis: `defmacro`, backquote (`` ` ``), comma (`,`), splicing (`,@`)
* Macroexpansión: `macroexpand`, `macroexpand-1`
* Crear tus propios controladores de flujo (`unless`, `my-when`, etc.)

---

## ✅ 6. Gestión de estado y entorno

**🎯 Objetivo:** Escribir programas con estado y alcance correcto.

### Contenidos:

* Variables globales vs locales
* `let`, `let*`, `progv`, `defparameter`, `defvar`
* Closures

---

## ✅ 7. Programación orientada a objetos con CLOS

**🎯 Objetivo:** Usar clases y métodos como en OOP.

### Contenidos:

* `defclass`, `make-instance`
* `defmethod`, `defgeneric`
* Herencia, métodos múltiples, discriminadores

---

## ✅ 8. Entrada/Salida y proyectos reales

**🎯 Objetivo:** Hacer programas reales que lean, escriban e interactúen con el entorno.

### Contenidos:

* Leer y escribir archivos: `with-open-file`, `read-line`, `write-line`
* Aplicaciones CLI
* Parsing, intérpretes, editores, herramientas útiles

---

## ✅ 9. Proyectos avanzados y ecosistema

**🎯 Objetivo:** Aplicar lo aprendido a sistemas reales.

### Contenidos:

* Usar [Quicklisp](https://www.quicklisp.org/beta/) (gestor de paquetes)
* Crear y distribuir tu propia librería
* Web con [Hunchentoot](https://edicl.github.io/hunchentoot/)
* Base de datos con [cl-dbi](https://github.com/fukamachi/cl-dbi)
* Juegos o gráficos con [CEPL](https://github.com/cbaggers/cepl)
* Crear tu propio lenguaje con macros

---

## 📚 Recursos recomendados

* 📘 *Practical Common Lisp* — Paul Graham (gratis online)
* 📘 *Land of Lisp* — Muy visual y divertido
* 📘 *On Lisp* — Paul Graham (avanzado, para macros)
* 🌐 [The Lisp Cookbook](https://lispcookbook.github.io/)

---

## 🧩 Bonus: Retos y ejercicios

* Resolver problemas de programación funcional (ej. Project Euler)
* Escribir un intérprete de expresiones aritméticas
* Simular estructuras como JSON o XML en Lisp
* Crear un DSL (lenguaje específico de dominio) para configuraciones
