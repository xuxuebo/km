package com.qgutech.pe.module.im.task;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.RejectedExecutionHandler;
import java.util.concurrent.ThreadPoolExecutor;

/**
 * 发送短信任务
 */
public class ThreadPoolExecutorPolicy {
    public static class WaitPolicy implements RejectedExecutionHandler {
        @Override
        public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
            final BlockingQueue<Runnable> queue = executor.getQueue();
            try {
                queue.put(r);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
