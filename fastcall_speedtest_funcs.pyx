cimport cython

def not_fastcall(*args):
    a, b, c, d = args
    return a+b+c+d

@cython.vectorcall_args("*")
def not_fastcall_(*args):
    a, b, c, d = args
    return a+b+c+d

def should_be_fastcall(a, *args):
    b = args[0]
    c = args[1]
    d = args[2]
    return a+b+c+d

@cython.vectorcall_args("*")
def should_be_fastcall_(a, *args):
    b = args[0]
    c = args[1]
    d = args[2]
    return a+b+c+d

def should_be_fastcall_kwds(**kwds):
    vals = kwds.values()
    x = "hello" in kwds
    total = 0
    #for k, v in kwds.items():
    """for v in kwds.values():
        total += v
    for k in kwds.keys():
        total += kwds[k]"""
    total = kwds['a'] + kwds['b'] + kwds['c']
    return len(kwds)

@cython.vectorcall_args("**")
def should_be_fastcall_kwds_(**kwds):
    vals = kwds.values()
    x = "hello" in kwds
    total = 0
    #for k, v in kwds.items():
    """for v in kwds.values():
        total += v
    for k in kwds.keys():
        total += kwds[k]"""
    total = kwds['a'] + kwds['b'] + kwds['c']
    return len(kwds)

cdef class C:
    def not_fastcall_kwds(self, *args, **kwds):
        vals = kwds.values()
        x = "hello" in kwds
        total = 0
        return len(kwds)

    @cython.vectorcall_args("**")
    def not_fastcall_kwds_(self, *args, **kwds):
        vals = kwds.values()
        x = "hello" in kwds
        total = 0
        return len(kwds)

not_fastcall_kwds = C().not_fastcall_kwds
not_fastcall_kwds_ = C().not_fastcall_kwds_


@cython.fastcall_args("both")
def callme_maybe(a, *args, **kwds):
    return len(args), len(kwds)

@cython.fastcall_args("**")
def callme_maybe_kwds(**kwds):
    return len(kwds)

@cython.fastcall_args("*")
def callme_maybe_args(a, *args):
    return len(args)

def forward_call_both(n, *args, **kwds):
    cdef int _
    for _ in range(n):
        res = callme_maybe(*args, **kwds)
    return res

@cython.fastcall_args("both")
def forward_call_both_(n, *args, **kwds):
    cdef int _
    for _ in range(n):
        res = callme_maybe(*args, **kwds)
    return res

def forward_call_kwds(n, **kwds):
    cdef int _
    for _ in range(n):
        res = callme_maybe_kwds(**kwds)
    return res

@cython.fastcall_args("**")
def forward_call_kwds_(n, **kwds):
    cdef int _
    for _ in range(n):
        res = callme_maybe_kwds(**kwds)
    return res

def forward_call_args(n, *args):
    cdef int _
    for _ in range(n):
        res = callme_maybe_args(*args)
    return res

@cython.fastcall_args("*")
def forward_call_args_(n, *args):
    cdef int _
    for _ in range(n):
        res = callme_maybe_args(*args)
    return res
