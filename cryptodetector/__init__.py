"""
Copyright (c) 2017 Wind River Systems, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software  distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
OR CONDITIONS OF ANY KIND, either express or implied.
"""

from os.path import dirname, realpath, join, basename, isfile
from os import listdir

from cryptodetector.logger import Logger
from cryptodetector.language import Language
from cryptodetector.output import Output
from cryptodetector.crypto_output import CryptoOutput
from cryptodetector.regex import Regex
from cryptodetector.rpm import is_rpm, extract_rpm
from cryptodetector.filelister import FileLister
from cryptodetector.method import Method, MethodFactory
from cryptodetector.options import Options
from cryptodetector.cryptodetector import CryptoDetector
#
#  Dynamically import all the methods
#
ROOT_DIR = join(dirname(realpath(__file__)), "methods")
print("ROOT_DIR::", ROOT_DIR)
for method in listdir(ROOT_DIR):
    try:
        for method_module in listdir(join(ROOT_DIR, method)):
            try:
                if not method_module.endswith(".py"):
                    continue
                module_path = ".".join(["cryptodetector", "methods", method, method_module[:-3]])
                __import__(module_path)
            except Exception as exe:
                print("Exception in cryptodetector methods:",exe)
    except Exception as e:
        print("Exception in cryptodetector methods:",e)
