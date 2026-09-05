# Relay Placement for Physical Layer Security: A Secure Connection Perspective

[中文](#中文) | [English](#english)

本仓库包含以下论文的 MATLAB 数值分析与仿真代码：

This repository contains MATLAB code for the numerical analysis and simulations in the following paper:

**Relay Placement for Physical Layer Security: A Secure Connection Perspective**  
**Jianhua Mo**, Meixia Tao, and Yuan Liu  
*IEEE Communications Letters*, 2012

[论文预印本 / Preprint（arXiv）](https://arxiv.org/abs/1204.1739) · [正式发表版本 / Published paper（DOI）](https://doi.org/10.1109/LCOMM.2012.042312.120582)

## 中文

### 简介

论文从安全连接的角度研究协作无线通信中的中继部署问题，考虑译码转发（decode-and-forward，DF）和随机化转发（randomize-and-forward，RF）策略，以及四节点和蜂窝网络场景。

本仓库的三个独立脚本用于：

- 在二维区域内搜索使中断概率最小的中继位置，并比较 DF 与 RF 策略。
- 分析窃听者逐渐远离时，直接传输与两种中继策略的中断概率及最优中继位置。
- 通过解析表达式、数值积分和 Monte Carlo 仿真，分析蜂窝网络中存在多个窃听者时的直接传输性能。

### 文件说明

| 脚本 | 功能与默认设置 | 输出 |
| --- | --- | --- |
| [`Relay_location_no_direction_link.m`](Relay_location_no_direction_link.m) | 固定源节点 `(0, 0)`、目的节点 `(1, 0)` 和窃听者 `(0.5, 0.5)`，路径损耗指数 `gamma = 4`；以 `0.002` 的网格步长搜索中继位置 | DF 和 RF 各一幅中断概率等高线图，标记网格内最优中继位置；命令窗口输出两种策略的最小中断概率 |
| [`Asymptotic_analysis.m`](Asymptotic_analysis.m) | 路径损耗指数取 `2, 3, 4`，窃听者从 `(0, 1)` 移动到 `(0, 10)`；在 `x ∈ [0.25, 0.75]`、`y ∈ [-0.3, 0]` 内以 `0.005` 的步长搜索中继 | 直接传输、DF 和 RF 的中断概率半对数曲线；工作区保留最优中继坐标及其到 `(0.5, 0)` 的距离 |
| [`Cellular_N_Eve.m`](Cellular_N_Eve.m) | 归一化圆形小区内的直接传输，路径损耗指数取 `2, 3, 4`；解析/数值结果覆盖窃听者数量 `N = 1, 2, 10`，Monte Carlo 仿真覆盖 `N = 2, 10`，每组 `K = 1e5` 次试验 | 中断概率随归一化源–目的距离 `d_sd / R` 变化的曲线，并叠加仿真结果 |

其中 `Cellular_N_Eve.m` 实现的是**无中继的直接传输基线**。

### 运行环境

- MATLAB。
- `Cellular_N_Eve.m` 使用 `exprnd`，需要 Statistics and Machine Learning Toolbox；另外两个脚本未调用该工具箱。
- 无需外部数据文件。

代码保留了较早版本 MATLAB 的写法，包括 `quad` 和数字位置参数形式的 `legend`。仓库未指定或验证最低兼容版本；若当前 MATLAB 对这些调用报错，可分别改用 `integral` 和 `'Location', ...` 形式的图例位置设置。

### 快速开始

将仓库下载到本地，在 MATLAB 中将当前文件夹切换到仓库根目录，然后按需运行任意脚本：

```matlab
% 四节点场景：二维中继位置搜索
Relay_location_no_direction_link

% 窃听者距离变化与最优中继位置分析
Asymptotic_analysis

% 蜂窝网络：多个窃听者下的直接传输
Cellular_N_Eve
```

建议逐个运行并查看结果。每个脚本开头都会清空工作区和命令窗口，并关闭已有图窗。脚本直接显示图形，不会自动保存图片或数据。

### 参数与结果说明

- **节点位置：** 前两个脚本将源节点和目的节点间距归一化为 `1`，通过 `xe`、`ye` 设置窃听者位置，通过 `e`、`f` 设置中继搜索网格。
- **路径损耗：** `gamma`、`gamma_range` 或 `alpha` 控制路径损耗指数；蜂窝脚本中的数值积分使用 `r` 表示该指数。
- **网格精度：** “最优中继位置”是指定离散网格中的最小值位置。缩小步长可以提高搜索分辨率，但会增加计算量与内存占用。
- **搜索与显示范围：** `Relay_location_no_direction_link.m` 默认搜索的纵坐标范围为 `[-0.5, 1.5]`，图中仅显示 `[-0.5, 0.5]`。修改场景时，可同时检查网格范围和 `axis` 设置。
- **随机仿真：** 蜂窝脚本未固定随机种子，不同运行的 Monte Carlo 结果会有小幅波动。如需可重复的随机结果，可在运行该脚本前执行 `rng(1)`。
- **图例：** 蜂窝脚本的图例仅标注路径损耗指数，多个 `N` 的曲线绘制在同一图中；各组窃听者数量以代码中的对应区块为准。

## English

### Overview

The paper studies relay placement in cooperative wireless communications from a secure connection perspective. It considers decode-and-forward (DF) and randomize-and-forward (RF) strategies in four-node and cellular scenarios.

The three standalone scripts in this repository:

- Search a two-dimensional region for relay positions that minimize outage probability, comparing DF and RF.
- Examine outage probabilities for direct transmission and both relay strategies, along with optimal relay positions, as the eavesdropper moves farther away.
- Evaluate direct transmission in cellular networks with multiple eavesdroppers using analytical expressions, numerical integration, and Monte Carlo simulations.

### Files

| Script | Purpose and default settings | Outputs |
| --- | --- | --- |
| [`Relay_location_no_direction_link.m`](Relay_location_no_direction_link.m) | Fixes the source at `(0, 0)`, destination at `(1, 0)`, and eavesdropper at `(0.5, 0.5)`, with path loss exponent `gamma = 4`; searches relay positions with a grid spacing of `0.002` | Separate outage probability contour plots for DF and RF, marking the optimal relay positions on the grid; minimum outage probabilities printed in the command window |
| [`Asymptotic_analysis.m`](Asymptotic_analysis.m) | Uses path loss exponents `2, 3, 4` and moves the eavesdropper from `(0, 1)` to `(0, 10)`; searches relay positions over `x ∈ [0.25, 0.75]`, `y ∈ [-0.3, 0]` with a grid spacing of `0.005` | Semilogarithmic outage probability curves for direct transmission, DF, and RF; optimal relay coordinates and their distances from `(0.5, 0)` retained in the workspace |
| [`Cellular_N_Eve.m`](Cellular_N_Eve.m) | Evaluates direct transmission in a normalized circular cell with path loss exponents `2, 3, 4`; analytical/numerical results use `N = 1, 2, 10` eavesdroppers, and Monte Carlo simulations use `N = 2, 10` with `K = 1e5` trials per configuration | Outage probability curves versus normalized source–destination distance `d_sd / R`, overlaid with simulation results |

`Cellular_N_Eve.m` implements the **direct-transmission baseline without a relay**.

### Requirements

- MATLAB.
- Statistics and Machine Learning Toolbox is required by `Cellular_N_Eve.m` for `exprnd`; the other two scripts do not call this toolbox.
- No external data files are required.

The code retains older MATLAB syntax, including `quad` and numeric location arguments for `legend`. A minimum compatible MATLAB version has not been specified or verified. If these calls produce errors in your MATLAB version, replace them with `integral` and the `'Location', ...` legend syntax, respectively.

### Quick start

Download the repository and set MATLAB's current folder to the repository root. Run any script as needed:

```matlab
% Four-node scenario: two-dimensional relay placement search
Relay_location_no_direction_link

% Eavesdropper distance and optimal relay position analysis
Asymptotic_analysis

% Cellular network: direct transmission with multiple eavesdroppers
Cellular_N_Eve
```

Run the scripts individually to inspect their results. Each script clears the workspace and command window and closes existing figure windows at startup. Figures are displayed directly; images and data are not saved automatically.

### Parameters and interpretation

- **Node positions:** The first two scripts normalize the source–destination distance to `1`. Set the eavesdropper position through `xe` and `ye`, and the relay search grid through `e` and `f`.
- **Path loss:** `gamma`, `gamma_range`, or `alpha` controls the path loss exponent. The numerical integration in the cellular script uses `r` for this exponent.
- **Grid resolution:** An “optimal relay position” minimizes outage probability over the specified discrete grid. Smaller grid spacing improves search resolution but increases computation and memory requirements.
- **Search and display ranges:** `Relay_location_no_direction_link.m` searches vertical coordinates in `[-0.5, 1.5]` by default, while displaying only `[-0.5, 0.5]`. Check both the grid bounds and `axis` settings when changing the scenario.
- **Random simulations:** The cellular script does not fix a random seed, so Monte Carlo results vary slightly between runs. For reproducible random results, execute `rng(1)` before running the script.
- **Legends:** The cellular plot legend labels only the path loss exponents, while curves for multiple values of `N` share the same figure. Refer to the corresponding code blocks for each group's eavesdropper count.

## 引用 / Citation

如果这些代码对你的研究有帮助，请引用对应论文：

If you find this code useful in your research, please cite the paper:

```bibtex
@article{mo2012relay,
  author  = {Mo, Jianhua and Tao, Meixia and Liu, Yuan},
  title   = {Relay Placement for Physical Layer Security: A Secure Connection Perspective},
  journal = {IEEE Communications Letters},
  year    = {2012},
  doi     = {10.1109/LCOMM.2012.042312.120582}
}
```
