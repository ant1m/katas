Emacs tips
===

I'll put there the emacs tips I came to use when I do stuff in Emacs in general and more specifically editing Scheme.

Use Paredit
---
Parentheses in Scheme are cool. They delimit expressions without ambiguity, allow homoiconicity and stuff. But when you spend a whole day dealing with parentheses, all those advantages are shadowed by petty drawbacks. [Paredit](http://www.emacswiki.org/emacs/ParEdit)'s precisely here for that : do interesting things without getting lost in parentheses.

My favorite way of installing stuff in emacs is with ELPA system. Once done, you only have to add :
    (require 'paredit)
in your config file to begin to walk the steep learning curve of Paredit. It's much less steep if you have the [cheat sheet](http://www.emacswiki.org/emacs/PareditCheatsheet) near you. Paredit is quite addictive.

Use Geiser
---
I was used to interacting with the Scheme REPL using [Quack](http://www.neilvandyke.org/quack/). The problem is: with Racket you have to write a small [hack](http://benjisimon.blogspot.com/2011/02/little-elisp-to-make-emacs-and-racket.html) in order to compile and load the current buffer. There is no problem with any other Scheme implementation, but I came to use Racket a lot and it was quite annoying. So I switched to [Geiser](http://www.nongnu.org/geiser/index.html). It has less features than Quack, but I don't miss most of the missing ones. It's a bit more painful to install, but not that much, and you don't do it every day.
It comes with a convenient [cheat sheet](http://www.nongnu.org/geiser/geiser_5.html).

Make Emacs do things for you
---
I am used to programming with the [TDD](http://en.wikipedia.org/wiki/Test_Driven_Development) set of practices. It makes you run tests very often. When i write katas, i write tests in the same file as the code that allows them to pass, so they are run each time I load the file in the REPL. I only have to bind the C-s key in emacs in order to save the file I'm writing in and loading it in the REPL at the same time. It's not very difficult, as Emacs is made for this.

Emacs works with hooks, that are activated with modes. For our concern we want this behavior to work only when we write Scheme files, i.e. when geiser mode is enabled.

First, we write the command that saves the buffer and compile and load the scheme file :
      
      (defun save-and-compile ()
        (interactive)
        (save-buffer)
        (geiser-compile-current-buffer))

In order to create a simple "command" in emacs lisp, you simply have to add the interactive function call at the beginning of the function. This one calls the save-buffer function and the geiser-compile-current-buffer function bundled with geiser.

We need something to bind our new command to a key in the geiser-mode keymap: 

      (define-key geiser-mode-map "\C-s" 'save-and-compile)

We have the function and the keybinding. Let's wrap them in an add on to the geiser-mode hook. The add on is a function called my-scheme-mode-hook : 

    		(defun my-scheme-mode-hook ()
    		  (define-key geiser-mode-map "\C-s" 'save-and-compile)
    		  (defun save-and-compile ()
    		    (interactive)
    		    (save-buffer)
    		    (geiser-compile-current-buffer)))
     		
And we add this add-on to the geiser-mode-hook :

      (add-hook 'geiser-mode-hook 'my-scheme-mode-hook)

And we're ready to go. 

In a similar intention here is a chunk of code that
* binds the f12 key to the compilation command,
* run the "runhaskell <filename>" as compilation command, with
<filename> as the name of the file of the current buffer,
* leaves the compilation window open when the compilation ended
abnormally or when a test failed, and closes it after 1 second if
everyhting is ok

     (setq compilation-read-command nil)
     
     (require 'haskell-mode)
     (define-key haskell-mode-map [f12] 'compile)
     
     (defun haskell-compilation-finish ()
       (setq compilation-finish-functions
             (lambda (buf str)
               (unless (or (string-match "exited abnormally" str)
                           (string-match "Failures: 0" (buffer-string)))
                 (run-at-time "1 sec" nil 'delete-windows-on
                              (get-buffer-create "*compilation*"))
                 (message "No compilation errors or test failures")))))
     
     (defun haskell-compilation ()
       (set (make-local-variable 'compile-command)
            (let ((file-name buffer-file-name))
              (format "runhaskell %s" file-name))))
     
     (add-hook 'haskell-mode-hook 'haskell-compilation-finish)
     (add-hook 'haskell-mode-hook 'haskell-compilation)
