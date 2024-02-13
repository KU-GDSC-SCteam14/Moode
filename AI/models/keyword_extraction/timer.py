import time

def timer(func):
    def wrapper(*args, **kwargs):
        st = time.time()
        rt = func(*args, **kwargs)
        print(f'### {func.__name__} time : {time.time()-st:.3f}ms')
        return rt
    return wrapper