import sys

from ml.metamath.backend import StandaloneFileBackend, NullBackend
from ml.metamath.parser import load_database
from ml.metamath.composer import Composer


def extract_lemma(input_composer: Composer, output_composer: Composer, thm_label: str) -> None:
    print("Extract Lemma")


def main() -> None:
    assert len(sys.argv) == 4
    _, input_mm, thm_label, output_mm = sys.argv
    input_composer = Composer(backend=NullBackend())
    input_composer.load(load_database(input_mm))

    with StandaloneFileBackend(output_mm) as backend:
        # initialize proof environment
        output_composer = Composer(backend=backend)
        extract_lemma(input_composer, output_composer, thm_label)


if __name__ == "__main__":
    main()