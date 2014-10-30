<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('drug')); ?>:
	<?php echo GxHtml::encode($data->drug); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('generic')); ?>:
	<?php echo GxHtml::encode($data->generic); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('cash')); ?>:
	<?php echo GxHtml::encode($data->cash); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('availability')); ?>:
	<?php echo GxHtml::encode($data->availability); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('special')); ?>:
	<?php echo GxHtml::encode($data->special); ?>
	<br />

</div>