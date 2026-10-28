"""Download the Steam Games dataset from Kaggle into seeds/raw_games.csv.

Usage (from the gaming_data/ folder):
    python scripts/download_data.py
"""

import shutil
import sys
from pathlib import Path

import kagglehub

DATASET = "fronkongames/steam-games-dataset/versions/56"
SOURCE_FILE = "games.csv"
TARGET = Path(__file__).resolve().parent.parent / "seeds" / "raw_games.csv"

# The upstream header is missing a comma between two columns.
BROKEN_HEADER = "DiscountDLC count"
FIXED_HEADER = "Discount,DLC count"


def main(target: Path = TARGET) -> None:
    dataset_dir = Path(kagglehub.dataset_download(DATASET))
    source = dataset_dir / SOURCE_FILE
    print(f"Downloaded {DATASET} to {dataset_dir}")

    target.parent.mkdir(parents=True, exist_ok=True)
    with source.open(encoding="utf-8", newline="") as src, \
         target.open("w", encoding="utf-8", newline="") as dst:
        header = src.readline()
        if BROKEN_HEADER in header:
            header = header.replace(BROKEN_HEADER, FIXED_HEADER)
            print(f"Fixed header: '{BROKEN_HEADER}' -> '{FIXED_HEADER}'")
        dst.write(header)
        shutil.copyfileobj(src, dst)  # stream the rest, the file is ~400 MB

    print(f"Wrote {target}")


if __name__ == "__main__":
    main(Path(sys.argv[1]) if len(sys.argv) > 1 else TARGET)
