(require 'auth-source)

(defun ma-bitlbee-identify ()
  "Auto-identify for Bitlbee channels using authinfo"
  (interactive)
  (when (string= (buffer-name) "&bitlbee")
        (let* ((entry (nth 0 (auth-source-search :max 1
                                                 :host "localhost"
                                                 :user "MAL1"
                                                 :port 6667)))
               (secret (plist-get entry :secret))
               (user (plist-get entry :user))
               (password (if (functionp secret)
                             (funcall secret)
                           secret)))
          (erc-message "PRIVMSG" (concat (erc-default-target) " account add sipe martin.apel@3ds.com,dsone\\\\" user " " password))
          (erc-message "PRIVMSG" (concat (erc-default-target) " account sipe set useragent \"UCCAPI/15.0.4771.1000 OC/15.0.4771.1001 (Skype for Business)\""))
          (erc-message "PRIVMSG" (concat (erc-default-target) " account sipe on"))
          )
        ))

(defun ma-bitlbee-ignore-unimportant (msg)
  "less noise from bitlbee"
  (if (string-match "localhost has changed mode for " msg)
      (setq erc-insert-this nil)))

(add-hook 'erc-insert-pre-hook 'ma-bitlbee-ignore-unimportant)
(add-hook 'erc-join-hook 'ma-bitlbee-identify)

(erc :server "localhost" :nick "martin" :password "")
(setq erc-autoaway-idle-seconds 1800)
(setq erc-minibuffer-notice nil)
(setq erc-autoaway-message "Away")
