try:
    import pandas as pd
    from rich.console import Console
    from rich.table import Table

    console = Console()

    def _rich_repr(self):
        table = Table(show_lines=True)
        for col in self.columns:
            table.add_column(str(col), style="cyan")
        for i, row in self.iterrows():
            style = "on grey15" if i % 2 == 0 else ""
            table.add_row(*[str(v) for v in row], style=style)
        with console.capture() as capture:
            console.print(table)
        return capture.get()

    pd.DataFrame.__repr__ = _rich_repr
except ImportError:
    pass
