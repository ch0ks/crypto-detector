# ECCN Crypto Scanner #

<!-- TOC -->

- [ECCN Crypto Scanner](#eccn-crypto-scanner)
  - [Introduction](#introduction)
  - [Encryption algorithms](#encryption-algorithms)
  - [Quick Start](#quick-start)
  - [Create Report](#create-report)

<!-- /TOC -->


<a id="introduction"></a>
## Introduction ##

The purpose of these branch is to create a quick Crypto detector for repositories in github and git.soma. We are scanning against 4800+ encryption patterns, see [README](README.md) for more information.

## Encryption algorithms ##

This script crudely detects the following cryptography schemes:

* Asymmetric cryptography

 >RSA, DSA, Diffie-Hellman, ECC, ElGamal, Rabin, XTR
* Block ciphers

 >AES, DES, RC2, RC5, RC6, CAST, Blowfish, Twofish, Threefish, Rijndael, Camellia, IDEA, SEED, ARIA, SM4, Serpent, SHACAL, GOST, TEA, XTEA, BTEA, SAFER, Feistel, IntelCascade, KASUMI, MISTY1, NOEKEON, SHARK, Skipjack, BEAR-LION, RFC2268, MARS, DFC, CSCipher
* Stream ciphers

 >RC4, Salsa20, XSalsa20, ChaCha20, PANAMA, SEAL, SOSEMANUK, WAKE
* Substitution ciphers

 >ROT13
* Hybrid encryption

 >PGP, GPG
* Hashing algorithms

 >MD2, MD4, MD5, SHA-1, SHA-2, SHA-3, MDC-2, BLAKE, HMAC, RIPEMD, HAVAL, Tiger, Whirlpool, GOST, Adler32, Streebog
* Protocols and standards

 >SSL, TLS, SSH, PKI, PKCS, MQV, kerberos, ASN1, MSCHAP
* Encryption libraries

 >OpenSSL, OpenSSH, libgcrypt, Crypto++, cryptlib, libXCrypt, libMD, glibC, BeeCrypt, Botan,
 BouncyCastle, SpongyCastle, QT, JAVA SE 7, WinCrypt
* Message Authentication Codes

 >HMAC, Poly1305

* Cryptographic random number generators

* And other generic encryption evidence

<a id="quick-start"></a>
## Quick Start ##

Clone repository
```
❯ git clone git@github.com:ch0ks/crypto-detector.git
Cloning into 'crypto-detector'...
remote: Enumerating objects: 625, done.
remote: Counting objects: 100% (20/20), done.
remote: Compressing objects: 100% (17/17), done.
remote: Total 625 (delta 2), reused 11 (delta 0), pack-reused 605
Receiving objects: 100% (625/625), 233.75 KiB | 653.00 KiB/s, done.
Resolving deltas: 100% (370/370), done.
❯ 
```

Checkout right branch
```
❯ git branch --show-current
master
❯ git checkout basic-improvements
Branch 'basic-improvements' set up to track remote branch 'basic-improvements' from 'origin'.
Switched to a new branch 'basic-improvements'
❯ git branch --show-current
basic-improvements
❯
```

Setup python environment
```
❯ pipenv shell
Launching subshell in virtual environment...
 . /Users/adrian.puente/.local/share/virtualenvs/crypto-detector-FyHWj_bL/bin/activate
❯ pipenv install
Installing dependencies from Pipfile.lock (a65489)...
  🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 0/0 — 00:00:00
❯
```

Create a list of repos.
```
❯ cat > sample-repo-list.txt << _END
git@github.com:SFDC/security-knowledge-base.git
git@github.com:SFDC/pulse-ui.git
git@github.com:SFDC/devops-center.git
git@github.com:SFDC/atlas.git
_END
❯ cat sample-repo-list.txt
git@github.com:SFDC/security-knowledge-base.git
git@github.com:SFDC/pulse-ui.git
git@github.com:SFDC/devops-center.git
git@github.com:SFDC/atlas.git
❯
```

Execute
```
❯ ./eccn-classification-list.sh sample-repo-list.txt | tee scan-output.txt
========== git@github.com:SFDC/security-knowledge-base.git ==========
Processing git@github.com:SFDC/security-knowledge-base.git
Cloning with command git, this depends on how the command is configured.
Cloning into 'security-knowledge-base'...
remote: Enumerating objects: 1541, done.
remote: Counting objects: 100% (390/390), done.
remote: Compressing objects: 100% (232/232), done.
remote: Total 1541 (delta 251), reused 266 (delta 157), pack-reused 1151
Receiving objects: 100% (1541/1541), 3.05 MiB | 1.13 MiB/s, done.
Resolving deltas: 100% (820/820), done.
removed 'security-knowledge-base-out/security-knowledge-base-FINAL.csv'
removed 'security-knowledge-base-out/security-knowledge-base.crypto'
removed directory 'security-knowledge-base-out'
Scanning for crypto
Reading configuration file /Users/adrian.puente/github/personal/crypto-detector/cryptodetector.conf
done
Files created:
    * security-knowledge-base.crypto
Processing security-knowledge-base.crypto ...
done
==]> Repo SFDC/security-knowledge-base contains 312 matches for crypto.
Final report in security-knowledge-base-out/security-knowledge-base-FINAL.csv
========== git@github.com:SFDC/pulse-ui.git ==========
Processing git@github.com:SFDC/pulse-ui.git
Cloning with command git, this depends on how the command is configured.
Cloning into 'pulse-ui'...
remote: Enumerating objects: 8300, done.
remote: Counting objects: 100% (827/827), done.
remote: Compressing objects: 100% (485/485), done.
remote: Total 8300 (delta 474), reused 553 (delta 325), pack-reused 7473
Receiving objects: 100% (8300/8300), 9.60 MiB | 1.16 MiB/s, done.
Resolving deltas: 100% (3229/3229), done.
removed 'pulse-ui-out/pulse-ui-FINAL.csv'
removed directory 'pulse-ui-out'
Scanning for crypto
Reading configuration file /Users/adrian.puente/github/personal/crypto-detector/cryptodetector.conf
done
Files created:
    * pulse-ui.crypto
Processing pulse-ui.crypto ...
done
==]> Repo SFDC/pulse-ui aparently has no crypto, review in detail.
Final report in pulse-ui-out/pulse-ui-FINAL.csv
========== git@github.com:SFDC/devops-center.git ==========
Processing git@github.com:SFDC/devops-center.git
Cloning with command git, this depends on how the command is configured.
Cloning into 'devops-center'...
remote: Enumerating objects: 17682, done.
remote: Counting objects: 100% (4203/4203), done.
remote: Compressing objects: 100% (1937/1937), done.
remote: Total 17682 (delta 2327), reused 3530 (delta 1952), pack-reused 13479
Receiving objects: 100% (17682/17682), 17.60 MiB | 1.08 MiB/s, done.
Resolving deltas: 100% (10857/10857), done.
removed 'devops-center-out/devops-center-FINAL.csv'
removed directory 'devops-center-out'
Scanning for crypto
Reading configuration file /Users/adrian.puente/github/personal/crypto-detector/cryptodetector.conf
done
Files created:
    * devops-center.crypto
Processing devops-center.crypto ...
done
==]> Repo SFDC/devops-center contains 28313 matches for crypto.
Final report in devops-center-out/devops-center-FINAL.csv
========== git@github.com:SFDC/atlas.git ==========
Processing git@github.com:SFDC/atlas.git
Cloning with command git, this depends on how the command is configured.
Cloning into 'atlas'...
remote: Enumerating objects: 11582, done.
remote: Counting objects: 100% (11582/11582), done.
remote: Compressing objects: 100% (3962/3962), done.
remote: Total 11582 (delta 8973), reused 9747 (delta 7155), pack-reused 0
Receiving objects: 100% (11582/11582), 2.79 MiB | 1.53 MiB/s, done.
Resolving deltas: 100% (8973/8973), done.
removed 'atlas-out/atlas-FINAL.csv'
removed directory 'atlas-out'
Scanning for crypto
Reading configuration file /Users/adrian.puente/github/personal/crypto-detector/cryptodetector.conf
done
Files created:
    * atlas.crypto
Processing atlas.crypto ...
done
==]> Repo SFDC/atlas aparently has no crypto, review in detail.
Final report in atlas-out/atlas-FINAL.csv
Final report in sample-repo-list.txt-list/sample-repo-list.txt-FINAL.csv
❯
```

Profit!
```
❯ grep "==]> Repo " scan-output.txt
==]> Repo SFDC/security-knowledge-base contains 224 matches for crypto.
==]> Repo SFDC/pulse-ui aparently has no crypto, review in detail.
==]> Repo SFDC/devops-center contains 28313 matches for crypto.
==]> Repo SFDC/atlas aparently has no crypto, review in detail.
❯
```

The CSV reports generated by each repo scan have a header and then line by line the evidence found while doing the pattern matching. If a CSV file has more than one line then some kind of crypto was found, otherwise is there is high certainity that the repo code does not have crypto.

## Create Report ##

Now take the file _sample-repo-list.txt-list/sample-repo-list.txt-FINAL.csv_ and import it into Google Spreadsheets using comma as the separator.
