import 'package:draggable_float/draggable_float.dart';
import 'package:flutter/material.dart';

class FloatingWidgetDemo extends StatefulWidget {
  const FloatingWidgetDemo({super.key});

  @override
  State<FloatingWidgetDemo> createState() => _FloatingWidgetDemoState();
}

class _FloatingWidgetDemoState extends State<FloatingWidgetDemo> {
  SnapDirection? _snapDirection;
  Offset _currentPosition = Offset.zero;
  int _selectedWidget = 0;
  final FloatingWidgetController _controller = FloatingWidgetController();

  @override
  Widget build(BuildContext context) {
    return FloatingWidget(
      key: ValueKey('$_snapDirection-$_selectedWidget'),
      padding: const EdgeInsets.all(16),
      initialAlignment: FloatingAlignment.bottomRight,
      snapDirection: _snapDirection,
      controller: _controller,
      onPositionChanged: (offset) {
        setState(() {
          _currentPosition = offset;
        });
      },
      floatingWidget: _buildFloatingWidget(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Floating Widget'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildInfoCard(),
            const SizedBox(height: 16),
            _buildSnapDirectionSelector(),
            const SizedBox(height: 16),
            _buildWidgetSelector(),
            const SizedBox(height: 16),
            _buildMoveToCenter(),
            const SizedBox(height: 16),
            _buildPositionDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingWidget() {
    return switch (_selectedWidget) {
      0 => FloatingActionButton(
          onPressed: _showTapSnackbar,
          child: const Icon(Icons.add),
        ),
      1 => FloatingActionButton.small(
          onPressed: _showTapSnackbar,
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.chat, color: Colors.white),
        ),
      2 => Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.widgets, color: Colors.white, size: 32),
        ),
      _ => FloatingActionButton(
          onPressed: _showTapSnackbar,
          child: const Icon(Icons.add),
        ),
    };
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.drag_indicator, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              'Drag the floating button around!',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'It stays within the screen bounds with configurable padding. '
              'Toggle snap-to-edge below to see it stick to sides.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSnapDirectionSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Snap Direction',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Animate to nearest edge when released',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 12),
            SegmentedButton<SnapDirection?>(
              segments: const [
                ButtonSegment(value: null, label: Text('None')),
                ButtonSegment(
                    value: SnapDirection.horizontal, label: Text('Horizontal')),
                ButtonSegment(
                    value: SnapDirection.vertical, label: Text('Vertical')),
                ButtonSegment(value: SnapDirection.both, label: Text('Both')),
              ],
              selected: {_snapDirection},
              onSelectionChanged: (value) {
                setState(() {
                  _snapDirection = value.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Floating Widget Style',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 12),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('FAB')),
                ButtonSegment(value: 1, label: Text('Small')),
                ButtonSegment(value: 2, label: Text('Custom')),
              ],
              selected: {_selectedWidget},
              onSelectionChanged: (value) {
                setState(() {
                  _selectedWidget = value.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionDisplay() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Position',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'x: ${_currentPosition.dx.toStringAsFixed(1)}  '
              'y: ${_currentPosition.dy.toStringAsFixed(1)}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoveToCenter() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Controller',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Move the widget programmatically',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  final size = MediaQuery.of(context).size;
                  _controller.setPosition(
                    Offset(size.width / 2, size.height / 2),
                  );
                },
                icon: const Icon(Icons.center_focus_strong),
                label: const Text('Move to Center'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTapSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('FAB tapped! Try dragging it around.'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
