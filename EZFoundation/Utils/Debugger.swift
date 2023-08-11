//
//  Debugger.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/8/11.
//  https://www.pointfree.co/blog/posts/70-unobtrusive-runtime-warnings-for-libraries

@inline(__always)
public func breakpoint(_ message: @autoclosure () -> String = "") {
#if DEBUG // Debug环境下
    var name = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
    var info = kinfo_proc()
    var info_size = MemoryLayout<kinfo_proc>.size
    
    let isDebuggerAttached = sysctl(&name, 4, &info, &info_size, nil, 0) != -1
    && info.kp_proc.p_flag & P_TRACED != 0
    
    if isDebuggerAttached { // 调试状态下
        fputs(
        """
        \(message())
        
        Caught debug breakpoint. Type "continue" ("c") to resume execution.
        
        """,
        stderr
        )
        raise(SIGTRAP)
    }
#endif
}
