from timeit import timeit
import pyximport; pyximport.install()

for func_name in ('not_fastcall', 'should_be_fastcall',
                  'not_fastcall_kwds', 'should_be_fastcall_kwds',
                  'forward_call_both', 'forward_call_args',
                  'forward_call_kwds'):
    print(func_name)
    number = 10000000
    args = "10000,2,3,4" if func_name.find("kwds")==-1 else "a=1,b=2,c=3,d=4"
    if func_name == "forward_call_kwds":
        args = "10000,w=1,x=2,y=3,z=4"
    elif func_name == "forward_call_both":
        args = "10000,2,3,4,w=1,x=2,y=3,z=4"
    if func_name.startswith("forward_call"):
        number = 1000
    print("Without", timeit("{0}({1})".format(func_name, args),
                            "from fastcall_speedtest_funcs import {0}".format(func_name),
                            number=number))
    print("With", timeit("{0}_({1})".format(func_name, args),
                         "from fastcall_speedtest_funcs import {0}_".format(func_name),
                         number=number))
    print()
