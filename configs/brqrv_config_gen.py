#!/usr/bin/env python3
from fusesoc.capi2.generator import Generator
import os
import shutil
import subprocess
import sys
import tempfile
if sys.version[0] == '2':
    devnull = open(os.devnull, 'w')
else:
    from subprocess import DEVNULL as devnull

class brqrvConfigGenerator(Generator):
    def run(self):
        script_root = os.path.abspath(os.path.join(os.path.dirname(sys.argv[0]), '..'))
        files = [
            {"configs/snapshots/default/common_defines.vh" : {
                "copyto"    : "config/common_defines.vh",
                "file_type" : "systemVerilogSource"}},
            {"configs/snapshots/default/eb1_pdef.vh" : {
                "copyto" : "config/eb1_pdef.vh",
                "file_type" : "systemVerilogSource"}},
            {"configs/snapshots/default/eb1_param.vh" : {
                "is_include_file" : True,
                "file_type" : "systemVerilogSource"}},
            {"configs/snapshots/default/pic_map_auto.h" : {
                "is_include_file" : True,
                "file_type" : "systemVerilogSource"}}]

        tmp_dir = os.path.join(tempfile.mkdtemp(), 'core')
        shutil.copytree(script_root, tmp_dir)

        cwd = tmp_dir

        env = os.environ.copy()
        env['RV_ROOT'] = tmp_dir
        args = ['configs/brqrv.config'] + self.config.get('args', [])
        rc = subprocess.call(args, cwd=cwd, env=env, stdout=devnull)
        if rc:
            exit(1)

        filenames = []
        for f in files:
            for k in f:
                filenames.append(k)

        for f in filenames:
            d = os.path.dirname(f)
            if d and not os.path.exists(d):
                os.makedirs(d)
            shutil.copy2(os.path.join(cwd, f),f)

        self.add_files(files)

g = brqrvConfigGenerator()
g.run()
g.write()
