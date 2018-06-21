package com.qgutech.km.utils;

import java.util.Random;

public class Randomizer {

    public static void main(String[] args) {
        int[][] randomize = randomize(10, 64, 65);
        for (int i = 0; i < randomize.length; i++) {
            for (int j = 0; j < randomize[i].length; j++) {
                System.out.print(randomize[i][j] + "  ");
            }
            System.out.println();
        }

    }

    public static int[][] randomize(int p, int m, int n) {
        long speed = System.currentTimeMillis() + ((int) (Math.random() * 10000));
        return randomize(p, m, n, speed);
//        return randomize(p, m, n, null);
    }

    /**
     * @param p 卷数
     * @param m 单卷题数
     * @param n 题库题目数
     * @return 第一维度是试卷，第二维度是卷内试题编号
     */
    private static int[][] randomize(int p, int m, int n, Long seed) {
        Random random = null;
        if (seed != null) {
            random = new Random(seed);
        }
        // 前提, p <= n, m <= n.
//        if (p > n) {
//            throw new RuntimeException("Paper count should not be larger than items in the repository");
//        }

        if (m > n) {
            throw new RuntimeException("Items in paper should not be larger than items in the repository");
        }

        int[][] a = new int[p][m];
        int total = p * m;

        int lcm = leastCommonMultiple(p, n);
        int[] permutation = toPermutation(n, random);

        for (int i = 0; i < total; i++) {
            int index = (i + i / lcm) % n;
            a[i % p][i / p] = permutation[index];
        }

        return a;
    }

    private static int leastCommonMultiple(int x, int y) {
        int m = x * y;
        for (int i = x > y ? x : y; i <= m; i++) {
            if (i % x == 0 && i % y == 0) {
                return i;
            }
        }
        return m;
    }

    private static int[] toPermutation(int n, Random random) {

        int[] permutation = new int[n];
        for (int i = 0; i < n; i++) {
            permutation[i] = i;
        }

        if (random != null) {
            for (int i = 0; i < n; i++) {
                permute(n, permutation, random);
            }
        }

        return permutation;

    }

    private static void permute(int n, int[] permutation, Random random) {
        int a = Math.abs(random.nextInt()) % n;
        int b = Math.abs(random.nextInt()) % n;
        if (a != b) {
            int temp = permutation[a];
            permutation[a] = permutation[b];
            permutation[b] = temp;
        }
    }
}
