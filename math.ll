source_filename = "math"

define i32 @fib(i32 %0) {
entry:
  %aptr = alloca i32, align 4
  %bptr = alloca i32, align 4
  %nptr = alloca i32, align 4
  store i32 %0, i32* %nptr, align 4
  %is_nlt1 = icmp slt i32 %0, 1
  br i1 %is_nlt1, label %err, label %noerr

err:
  ret i32 -1

noerr:
  %is_nlt3 = icmp slt i32 %0, 3
  br i1 %is_nlt3, label %lt3, label %body

lt3:
  ret i32 1

body:
  store i32 1, i32* %aptr, align 4
  store i32 1, i32* %bptr, align 4
  br label %loop.cond

loop.cond:
  %n = load i32, i32* %nptr, align 4
  %is_ngt2 = icmp sgt i32 %n, 2
  %n_minus = sub i32 %n, 1
  store i32 %n_minus, i32* %nptr, align 4
  br i1 %is_ngt2, label %loop.body, label %end

loop.body:
  %a = load i32, i32* %aptr, align 4
  %b = load i32, i32* %bptr, align 4
  %t = add i32 %a, %b
  store i32 %b, i32* %aptr, align 4
  store i32 %t, i32* %bptr, align 4
  br label %loop.cond

end:
  %answer = load i32, i32* %bptr, align 4
  ret i32 %answer
}

